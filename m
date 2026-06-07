Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E17CD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWJll-0001sy-1V; Sun, 07 Jun 2026 16:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wWJlj-0001sc-Oz
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 16:06:51 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wWJlh-0000Xk-Bo
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 16:06:50 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-9158fbaa4bbso417099585a.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 13:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780862807; cv=none;
 d=google.com; s=arc-20240605;
 b=c7Y+lnHUD+TOeZ6X8RAL5UbLVz/ue1dIUyQEr7SSyNidJJ5i37WJnZ4Xn0lxxn7kda
 C2TiGJ1wXHFoM6Or79u96Zm0gdjT0mg8khOMMprfRo2FLoMaPqbwJ3+Javao7pTENc1R
 j6Y+c9dQzATKT4IsxqIZaK34mcx2GFLTp7y7M2uTlYO0fE7Gi38ntvKGELhnKk6e0Ph7
 dYbE2VzMbLrF3iAFu8hYRf19Hps7sTFnTfxak9rAdgG7DqjuqELKLVA77FjPMgWialif
 33kHoZpO7eHybRvAqOAvYdUZN8+DsmPT4SJ1EJCIVjBk7l16L05oCk0typpIyH0x1TYP
 qtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SyWRMsRsIis9tdHllM2jJgDcp0mpM1nhxFAF+wOcW38=;
 fh=FpVn51f7DcT5MzflneaVHJ9yKzeMunHRcwvV5jfuaAo=;
 b=b8T5igvJNdrZbrTtriLFbFs66eQVbS4aTNQX88r0wGal1VPqdeFXX1+ChzyN+voFEc
 U7Ii+JaDYg3hbgkFDxg1gm1hF69SD1BIxDVCmPilg4ba2YhmE6YX5QIsTWyEpb3/rtlU
 GYktvfriMY84kM9699GaYkNCF1t9HUu3iWpzyjqqbfKQjDKGTWi0ioHNxqoU/Db4dXN+
 P0xVuvPg+HPofjBKNWca5nJeWXz0DoUrxjtCDU27Q/fQ1UjVrub1fGpCMkcw7mUoLM58
 rIi9ngxQThOD2f0xbu4UCsvOTXPDBh8sQqxiQQzaMCD0UOlu3QkNwgiCVHQkgtoK7vtO
 EjNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780862807; x=1781467607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyWRMsRsIis9tdHllM2jJgDcp0mpM1nhxFAF+wOcW38=;
 b=ahQgESqKxVyu/N4sDa92dAsipveEC0av+9OPhFE5s7LaJIYErAopXhdV9dVPANENZo
 mtvfmM6GEHlFWJoZ+0K90iyeOlMwIw6NljFUXLdH4GCVOEmnvRXON50DNiQg42m3nL6k
 kaMHAHfoXLUyDtnRzCDjVJJWMWkXy8aq7fTvbkFB6dumY2NdwQDC/pHGEX+CWrmSMW97
 8kqXpI9o0f5sGutvp1NwtFcQJnblJCbhvmdb7RNVfAqnQU5DOW0ZFyytSpGZM/jEl1jI
 56hdciCXIwNc7gOJZ211cty51a106jQ5SqaukGs86EJHViuNgP71iO5AnTuRFQ8RSGnX
 Hkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780862807; x=1781467607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SyWRMsRsIis9tdHllM2jJgDcp0mpM1nhxFAF+wOcW38=;
 b=pfCZiAn0U4tX4yM/i6qbJm8fn125MYPb/pZoNqB9fiAtR7K1fnxlRnxvHnAC1YHJw/
 tWH5P7z4XpAtokLu1gNH6dADHO2EfwjLwc9RC/Rjy+bzdOtj4F+7O0kggMAbCHSmEyRy
 x9LxzREUxLXGWgWm9cillTWXl9iCISDiIdIesVi6nV38ftNolDvJvKVpZnyA8G87m0YX
 O611SjQLKtiIWF7K/ZtA/rSzVrT6Zh6UkNwPkZWYVvcyops4q+4aJuNBzZORUjOL8Mzt
 IdzEhtJ2fxPXMuntLcUfS5o3oqfNpfKNeTwpbLCXOu7dsGJGRGrbbUTamrV42y500FeU
 4S2Q==
X-Gm-Message-State: AOJu0YwNqTY2T8aOFSBgjsFDpf8G4IwmiK7xhAQQkmu+qi/KELSJA4gU
 s2IpbMO2qbw8IgrKC5qERhkSZtkQfp3RDsMnFl9bo4pJWhMSfLYgxmyCem4UkBVRgBpM8EwPQ5T
 Ibz6qBwR5m3ud8NzbDkkyz/9xhTETv3g=
X-Gm-Gg: Acq92OHlmQRNz5iALs2WInPBBfgCTd8Fb34ahINZ1G8Vf6LHD0JwATAS3Z3kW/SDGeZ
 AhvaWQPEsBMYWjxDVwsvEItJILUq2MMLOwre2oEOov1pT2HCJViUEiu3VzcFpJhbVf3aukUARzd
 IYC0LYUZZmZ29KDQIfvKR6F6qmA05xS2oE993eDh0TG80Oy9Sqadf+jAhAoQYCqeusA89JHPG67
 geKhw1e25JgjSClYrnANVotwHxw0T5tMFXhoL7z9nbvrOnb57ExXylnLGPpva7qPnf8NbTVWTfU
 08+sb6I6Ri1zmxwlfAEJZeslOhDx9zuOMuEtSiaNNL3/d6aLK2VNskAbFIOoCXNFnLCflUz4ldX
 FEFCxld6/Ja1sAD7tOrG5M5YJG1tE+gkEiexh
X-Received: by 2002:a05:620a:6505:b0:915:7c1a:1390 with SMTP id
 af79cd13be357-915a9d5859amr2315347185a.39.1780862806898; Sun, 07 Jun 2026
 13:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260607140356.10702-1-deller@kernel.org>
 <20260607140356.10702-10-deller@kernel.org>
In-Reply-To: <20260607140356.10702-10-deller@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 7 Jun 2026 13:06:35 -0700
X-Gm-Features: AVVi8CcSo9avB4tVy0dSJtDZi-EgKRwLES_NSFjiyyp7X0CUXvMHIldh8iuO6T8
Message-ID: <CAMo8BfKSegeBHdKaxiXp3RQ+XX-BO9sztt-MucX_cWR=frnxfA@mail.gmail.com>
Subject: Re: [PATCH 09/10] linux-user/xtensa: restore FP rounding mode on
 sigreturn
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Jun 7, 2026 at 7:04=E2=80=AFAM Helge Deller <deller@kernel.org> wro=
te:
>
> From: Matt Turner <mattst88@gmail.com>
>
> The Xtensa FCR rounding-mode (RM) bits are not held only in
> env->uregs[FCR]: they are also reflected into env->fp_status via
> set_float_rounding_mode().  Similarly, FSR exception flags are mirrored
> into env->fp_status.  Every write to FCR/FSR goes through
> helper_wur_fpu{2k,}_fcr / helper_wur_fpu_fsr which keep the two in sync.
>
> restore_sigcontext() previously wrote nothing back for xtregs, leaving
> env->fp_status with whatever rounding mode and exception flags the
> signal handler last installed.  Any FP instruction in the interrupted
> code could then operate with the wrong mode.
>
> Add a minimal target_xtensa_xtregs sub-frame carrying FCR and FSR.

The structure of the xtregs area is defined by the target xtensa core and
this definition doesn't match what a typical core with FPU would produce.

Also this area saves not only FCR and FSR, but all of the FPU registers,
which are caller-saved. Not saving them means that any operation
that touches FPU registers in the signal handler context will clobber
them for the code that was interrupted by the signal.

> setup_sigcontext() saves the current values and points sc_xtregs at the
> sub-frame when XTENSA_OPTION_FP_COPROCESSOR or
> XTENSA_OPTION_DFP_COPROCESSOR is present (both use env->fp_status driven
> by FCR/FSR). restore_sigcontext() reads sc_xtregs; if non-zero it
> restores FCR and FSR through cpu_set_fcr()/cpu_set_fsr() so fp_status
> round-trips correctly across signal delivery.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/xtensa/signal.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
> index ef8b0c3a27..fef23952b7 100644
> --- a/linux-user/xtensa/signal.c
> +++ b/linux-user/xtensa/signal.c
> @@ -21,6 +21,7 @@
>  #include "user-internals.h"
>  #include "signal-common.h"
>  #include "linux-user/trace.h"
> +#include "target/xtensa/cpu.h"
>
>  struct target_sigcontext {
>      abi_ulong sc_pc;
> @@ -43,10 +44,15 @@ struct target_ucontext {
>      target_sigset_t tuc_sigmask;
>  };
>
> +struct target_xtensa_xtregs {
> +    uint32_t fcr;
> +    uint32_t fsr;
> +};
> +
>  struct target_rt_sigframe {
>      target_siginfo_t info;
>      struct target_ucontext uc;
> -    /* TODO: xtregs */
> +    struct target_xtensa_xtregs xtregs;
>      uint8_t retcode[6];
>      abi_ulong window[4];
>  };
> @@ -107,6 +113,7 @@ static int flush_window_regs(CPUXtensaState *env)
>  }
>
>  static int setup_sigcontext(struct target_rt_sigframe *frame,
> +                            abi_ulong frame_addr,
>                              CPUXtensaState *env)
>  {
>      struct target_sigcontext *sc =3D &frame->uc.tuc_mcontext;
> @@ -123,8 +130,15 @@ static int setup_sigcontext(struct target_rt_sigfram=
e *frame,
>      for (i =3D 0; i < 16; ++i) {
>          __put_user(env->regs[i], sc->sc_a + i);
>      }
> -    __put_user(0, &sc->sc_xtregs);
> -    /* TODO: xtregs */
> +    if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)=
 ||
> +        xtensa_option_enabled(env->config, XTENSA_OPTION_DFP_COPROCESSOR=
)) {
> +        __put_user(env->uregs[FCR], &frame->xtregs.fcr);
> +        __put_user(cpu_get_fsr(env), &frame->xtregs.fsr);

cpu_get_fsr() is introduced in the next patch of the series. It should go b=
efore
this one to keep the series bisectable.

> +        __put_user(frame_addr + offsetof(struct target_rt_sigframe, xtre=
gs),
> +                   &sc->sc_xtregs);
> +    } else {
> +        __put_user(0, &sc->sc_xtregs);
> +    }
>      return 1;
>  }
>
> @@ -190,7 +204,7 @@ void setup_rt_frame(int sig, struct target_sigaction =
*ka,
>      __put_user(0, &frame->uc.tuc_flags);
>      __put_user(0, &frame->uc.tuc_link);
>      target_save_altstack(&frame->uc.tuc_stack, env);
> -    if (!setup_sigcontext(frame, env)) {
> +    if (!setup_sigcontext(frame, frame_addr, env)) {
>          unlock_user_struct(frame, frame_addr, 0);
>          goto give_sigsegv;
>      }
> @@ -266,7 +280,19 @@ static void restore_sigcontext(CPUXtensaState *env,
>      for (i =3D 0; i < 16; ++i) {
>          __get_user(env->regs[i], sc->sc_a + i);
>      }
> -    /* TODO: xtregs */
> +    {
> +        abi_ulong xtregs_addr;
> +
> +        __get_user(xtregs_addr, &sc->sc_xtregs);
> +        if (xtregs_addr) {
> +            uint32_t fcr, fsr;
> +
> +            __get_user(fcr, &frame->xtregs.fcr);
> +            __get_user(fsr, &frame->xtregs.fsr);
> +            cpu_set_fcr(env, fcr);
> +            cpu_set_fsr(env, fsr);

Same here.

--=20
Thanks.
-- Max

