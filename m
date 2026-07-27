Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4604DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woM7x-0002t9-Hf; Mon, 27 Jul 2026 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1woM7k-0002sP-Da
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:16:09 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1woM7i-0000YP-Ay
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:16:07 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69c7ab350e9so3980338a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785161764; cv=none;
 d=google.com; s=arc-20260327;
 b=AqUFGCX94X/c3B0DyjdTOblaPsKkCeYYvmW5WOt50xtiIizanR0W0O38R9FOfCJdIP
 BrI3C/M7dWGEspeBkna/tFt0znuaXEzXYg8Fl4kc9cOiWCk/tDXQfJ47JPtvoFJtvRv8
 ZQO5L8oV+gb7OSFfYF76NcQz0euhFKGT4X8V+G1QNENYyPqiJhuYGMSr0azt4jxHrI7H
 dkgPmxVzvP1PPGnGqXxKWtqye2lZJi86OSpYcehd0+/zaaXEq5TdtWbBUfXBBZ1jdv2Z
 OzSp2nJVq/kKFLgUP+X5wCXiHPLqqLahLDgnId+ae8W2qTNX0ClgtSOw1LzclEXskACJ
 S4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KncBj/gWUKcIXO7jh2ZCdjkxUZVB+ayks6/J00fTaUI=;
 fh=zhL/hnhC/pXYJxyIhRsYDtwiMu/6/LJyk0IhYyc6R/4=;
 b=QnmED9mWWnh7kTaCPRW4i4+IfmiilFU94V0E9Xe03wKe1BwJFpvOGCsyRXHy743LWU
 0x8ERCZ04iaqmrC0IYKpR7gxuNWKL6lWOp1r3FNCoRykbLlNoMfwukNAxP6gNwCceCoH
 p0pAw5JYORvLc3jFO9X5kGRy7DG6P1B8aOr39JDpKm7G0tkyIcYLvDEyCqVJnAbrMvhJ
 DqdYQNavHqjKGZtXKVHZQfe/7n8dnrrsj7hhABttco5BU6mVqrcNl24Ol+zvEpQVtMYd
 SBB7SOeHnNGdo+MrT2zISZQ+45orWafhG2IKI9a/wUXiHtM4UPlZDmN2D/eDfHdVXrPW
 Rdbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785161764; x=1785766564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KncBj/gWUKcIXO7jh2ZCdjkxUZVB+ayks6/J00fTaUI=;
 b=DpSqxSRSA5sDcPwbf81cXlbFSWe8UcnPsA/gfa4nvovb7XBNY9UIiYwfw0TtvyM5Zd
 k7Ss3TuBfr4aH3wmR9a1nF0P5YEBfY6KMDzayNo5TGxCHjnK6izStnK7CrRnl8SAxvC1
 nKdmd8uaSGvreooILyIHQOHwsWT9BkfKWpc8LISSazPT180DEXc6RK5XLnsd27/qCLts
 tUHdWFW+P6aa0Wq0jT7JJXYilcZPlI0MUI5EgHBSxkVA+2xJ5NnFSRPlwDvoiBYj371Z
 U/Xx5YOs3AWgJrzOpA5a96h4qGJM0Y6muv6QUIE0x21vHRctODUFFx3NVfYaQOnRrIwF
 gvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785161764; x=1785766564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KncBj/gWUKcIXO7jh2ZCdjkxUZVB+ayks6/J00fTaUI=;
 b=MTkm6bqZJUJ/KoCLMp7+glDsX0YWwKS5r+3acEG73n5ri+ro0fOn1SpXROEMbhsZ0e
 sclAl5Zt77xFMF0mQnewGpSg12ackPydeJ3Zoqs0FSk8elQ3Eea5qgL7qNJacdXkatvp
 0fxV2QDlAHHDHrnrKwnTyBXbNdf8Kc8BE16qijcPSxAkmwg/dv7JdEPMkPuGYczcK+3V
 5wgVy7wiaHVVBgY3cWp8V85TR+Dgne3Xik4yTpkTkp3xFNNshU6uDiidgZlxAIqbMWhO
 DzrsyNQmqSUDMPwH4ZghXS9ZIG24Tdubj8vQrvnlOCMpmvD69jXpVJb5eplNJzymRT8c
 rjNw==
X-Gm-Message-State: AOJu0YwqqGzdMPPMzg1kQQivTANOfQrOaAXEGJyx6/rDlnrGXtZSGnT0
 V812Ln9TAy728Zw88Uki0kylNvcm3ci7ZN0zs5EboSFxlGObT/ufLuSImAHALL4u00eFX4K7kmP
 Pg3YaTrG8JsEd9gB6sWR4TjrudbRr7Qo=
X-Gm-Gg: AR+sD13wgpk9htLh96NyUYd5KSyTpunMS91kp8U/wWQIVoQZRdDfQoNBrXjlMlzy+Fz
 qHYmT0APupFvfw1w3mCg9/I+wn/aND9P6Hwz2yMhl+uL+rVN5aDrRonOC2U+Hv9pDZpsixChMEP
 Fxuixfo15Hrh6PCFWuGWv0cctARFDQwZ/WcRW0Izs3JcVVft2+Q9gv644jZVXFbSE+vvMKqMjx1
 G190BG/spVVzt1tYKJik8+Kg9aapij4PeXZGQPdHqo8vMCqX0pGKXfjrybK91fNh4Gom1KWAnqL
 LxP+VPVWNZGpFDPQXt7TMJU24/7h4A==
X-Received: by 2002:a05:6402:501e:b0:69f:b1d3:3903 with SMTP id
 4fb4d7f45d1cf-69fc100565bmr3264167a12.8.1785161763569; Mon, 27 Jul 2026
 07:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260726193636.110586-1-deller@kernel.org>
 <20260726193636.110586-3-deller@kernel.org>
In-Reply-To: <20260726193636.110586-3-deller@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 27 Jul 2026 10:15:51 -0400
X-Gm-Features: AUfX_mx5tGXwoRetBzjvHiW-ujGC4y8uZL2f0AZb-g9eFbSviQr6SMdX0oRkgRM
Message-ID: <CAJSP0QVMP8dPx4-123C8HtryogHyhcwBRdFUe5HcfGu8i2EbJg@mail.gmail.com>
Subject: Re: [PULL 2/2] linux-user: fix guards for the fsmount(2) syscall
 series
To: Helge Deller <deller@kernel.org>, Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

On Sun, Jul 26, 2026 at 3:36=E2=80=AFPM Helge Deller <deller@kernel.org> wr=
ote:
>
> From: Matt Turner <mattst88@gmail.com>
>
> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
> macro exists, so the guard is never true and the entire series compiles
> out. Guests calling any of the four get -ENOSYS, which for example makes
> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
>
> The strace bits for fsconfig() have the same typo.

Please take a look at the following CI failure:

../linux-user/strace.c: In function =E2=80=98print_fsconfig_cmd_name=E2=80=
=99:
../linux-user/strace.c:4352:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=99 =
undeclared
(first use in this function)
4352 | case FSCONFIG_SET_FLAG:
| ^~~~~~~~~~~~~~~~~

https://gitlab.com/qemu-project/qemu/-/jobs/15553379213#L2358

Once this has been fixed, please send a v2 pull request. Thanks!

Stefan

>
> Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscalls=
")
> Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls")
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/strace.c    | 2 +-
>  linux-user/strace.list | 2 +-
>  linux-user/syscall.c   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3a81cc95f4..af1cf9548a 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct sys=
callname *name,
>  }
>  #endif
>
> -#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
> +#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)
>  static void
>  print_fsconfig_cmd_name(int cmd)
>  {
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index e363892e0a..ba1c1dc0ae 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1725,7 +1725,7 @@
>  #ifdef TARGET_NR_fsopen
>  { TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
>  #endif
> -#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
> +#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)
>  { TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
>  #endif
>  #ifdef TARGET_NR_fsmount
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3da5530d42..740142825d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9740,7 +9740,7 @@ _syscall5(int, sys_move_mount, int, __from_dfd, con=
st char *, __from_pathname,
>             int, __to_dfd, const char *, __to_pathname, unsigned int, fla=
g)
>  #endif
>
> -#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
> +#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
>  #define __NR_sys_fsopen __NR_fsopen
>  _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
>  #define __NR_sys_fsconfig __NR_fsconfig
> @@ -14485,7 +14485,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env=
, int num, abi_long arg1,
>          return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
>  #endif
>
> -#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
> +#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
>      case TARGET_NR_fsopen:
>          {
>              p =3D lock_user_string(arg1);
> --
> 2.54.0
>

