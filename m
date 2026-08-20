Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74542C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx6H0-0001eC-2l; Thu, 20 Aug 2026 13:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wx6Gx-0001dA-Q9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 13:09:47 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wx6Gr-0001iv-Nh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 13:09:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-836c91bd782so2275657b3.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787245780; cv=none;
 d=google.com; s=arc-20260327;
 b=VU7QHXyHF1Kebja0Is3IIe5WKjGqaXUscfd07HDvccOaWA4h36GjObrqp4lnWWWlBG
 C0j2XgxNC3nVp2PoaonhCAHIW1iCBVekbfA3H+yh9t4/9xlXFzw1Zi/zI+Y85wZ0x3FH
 q4gKScrL/baKypDbnvANZ/0/GuIX2cLdy1IrUnJpERs85rOXoKRAg1QdUvYbLQvBojFP
 2v9iwWedlgdRtz9WAadEkUT82IK7uBQqtSkgXqtYCvKgpv6aUunVROoctiCVA4wm8dsx
 jkmbompxcieWWe4xLmyH0ZRp6JhskmJdOYECSn4ZkfFxO6gdtCCh7J1uZdcUCW+2zF7x
 iSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wLVNGp1TrXL/BejdX3jNwBZK07UE4WlYLsz9cGAtoNc=;
 fh=jANn+OmfhdFtHGL1yTKCdKAvCPMOf6gyXHNlUQ9OX58=;
 b=abLAND86bD9FyqEtj2rrLXkN5hrs2/8NuwQqRMkUr1jJFOwA3wEbw9+lQnkctB+E37
 iGAZ4FXQhDp0Gd29Azk6ZacDZTGk/nqrDrB8fJKRfX5eCUMJg4/0wHUu4wtHp7Rub0Yt
 BKxjTsjBaPD8sPI1AmU9wuPtc+ar/4ECWq+rsmB7dH6RwCcukPtbmpEf4m2AXxSk+Yu1
 IiKrUD66mvqjPkAPuOI/LFTFMN+XwGfBZ/No4329ZeTO2BdmCO1+k6ByzecWwMd4KEVI
 n0cI/yU4agOGXCnJo64rp4IhR1OzmBvSGSSlDeEOWW2KjHvPzdorZpi5z1M1AQRu+NaG
 lNSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787245780; x=1787850580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wLVNGp1TrXL/BejdX3jNwBZK07UE4WlYLsz9cGAtoNc=;
 b=bc/kJXJN9pwFPFxyFni0XE8ZCUqm4KII8nkLaiUuRutQrm+hh1tPQDVmUvx7g0oERN
 kUknfz4ZqI0e2bnzU7h96sK7bwF7+haJ2JjQ62FZaisJQSXcP/OMFnMpiGTuwEHukY8p
 MsNOhSE0OWNzMa71r++XSDxFD/bswWuRxYywS5shxooJKMROLMubQjkMg8vTtTd9ubTh
 I8talFsB4IRHpvmGJ4ICfWpBmRGGCWv8hwUs7ej9yn2hUAc81PKU0HsCi739rhzWjIKf
 YkgW2Eqg1T6ekKr1POubEHhZQh7eBgMZQUkv6ilwmjsMaLCcLzSKMtKk1x/bHiJszHpu
 DRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245780; x=1787850580;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wLVNGp1TrXL/BejdX3jNwBZK07UE4WlYLsz9cGAtoNc=;
 b=oqvWBRAldysojpJPCV8aPS/5MZs1w1DgPgf1sisQngMXO1CwKqQ/afa3D5RnWIpNx2
 en9WLXI+gWVHj+KIaYUSwcICYmFKvmp6OyqF6012GybJHALPU4eMmSKkZ97teWL3aRKC
 4F5+GqKl9X9Np7SpyZvd44BhMeBxtSMqA8BA104Af60yrlYTpJjZxcqjUtRSF1eqqnc8
 rqTqVXgweO6xuckGE0BoTO1SYz3oHkyQU5tIGPmPtkRjKdB1Bl5R3GwYAEh8KAVHCRCT
 IpbW67tGo9OTE/gnUp4XZrwayyAzFZ0RoMY7vdHCS8xD/AHIeOfsCXCzeWqR5vgyXwbf
 ZuSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmJPEszqP/FrAZQbu8hlOEBDs7oCGQr3GUaWTZGd/gvwxa+MOQB+lNeQKFVXsdQxZK8G71DrabzoQJ@nongnu.org
X-Gm-Message-State: AFuF++lARpEYd77or8Htsx71O+2KWnfnrxZZYRLrnZAoRwiOdUJGxXGi
 w/7nCR8kyE03Znw8eHtIJTWQLjd8M9Zvno0/Hai5zcy+vBNVLZQHjFq6kYaz6GEu0Z/9YT11zWM
 rI8EG4sV678c9BEza13qkuGecXCp299Y=
X-Gm-Gg: AR+sD12Y92dZnnDrJ5MZnJ5Lwqxw3cYUV+Rms7afg+e2c6N9UJ5KKsyu/hQAEK8Cxk1
 n1lxQ7MT/HiPiNOGwdbV3bIREt25YiDn0k1OVX6IIok40vRspm1xIm4VV1H5d42nFdw2hURZhFC
 9nxMoqxTBvTu8cXhxWzYNn6S9FmiGbTgorE5J71P93c30UHbup+S6KM3W16q3/sHC75Yqh5VYef
 ghEfOn5GcKkQ2kdQk0amAfQuSbAYNxxLDlfeIzBV/COgWw/E9m5jIV4E1U6ZdNEBdSWwOHp3TOJ
 OBj/K+9xDN5DK/1FORdn7kN6LaQxNkwDGTYOb1XVQdICAonbI1qIidEC2BMHn3IkNHfDOoDWHaw
 E
X-Received: by 2002:a05:690c:e3c2:b0:847:8ef9:fa2e with SMTP id
 00721157ae682-8478f093dc5mr27474467b3.10.1787245780046; Thu, 20 Aug 2026
 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-10-philmd@oss.qualcomm.com>
 <0b70e3cc-e14f-4737-b265-c7d12898169a@linaro.org>
 <854739cc-1275-4324-aaea-576f0a504172@oss.qualcomm.com>
 <fb2425af-9f89-4413-a31e-1f22fd42d869@oss.qualcomm.com>
In-Reply-To: <fb2425af-9f89-4413-a31e-1f22fd42d869@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Aug 2026 21:09:23 +0400
X-Gm-Features: AcwNN1W9ltniWMbSgs1PGJ3frjaMCXMbmdQyqmJcJk98cxS_OW0FuKRKMguRMSE
Message-ID: <CAJ+F1CKqhB-7MPHQZ6_8NbA7Mq9eUmkDD3rn7-dgTVJErYcshg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment
 accessors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 20, 2026 at 8:52=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 2026-08-20 18:24, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 2026-08-20 17:21, Richard Henderson wrote:
> >> On 8/20/26 03:47, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Introduce const-qualified variants of cpu_env() and
> >>> env_archcpu(), to safely access CPU architecture
> >>> state when it should not be modified.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >>> ---
> >>>   include/exec/cpu-common.h | 11 +++++++++++
> >>>   include/hw/core/cpu.h     |  6 ++++++
> >>>   2 files changed, 17 insertions(+)
> >>>
> >>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> >>> index 6594f7fa1be..f3a3799f451 100644
> >>> --- a/include/exec/cpu-common.h
> >>> +++ b/include/exec/cpu-common.h
> >>> @@ -79,6 +79,17 @@ static inline bool cpu_loop_exit_requested(const
> >>> CPUState *cpu)
> >>>   }
> >>>   #endif /* CONFIG_TCG */
> >>> +/**
> >>> + * env_archcpu_const(env)
> >>> + * @env: The architecture environment (const).
> >>> + *
> >>> + * Return the const ArchCPU associated with the environment.
> >>> + */
> >>> +static inline const ArchCPU *env_archcpu_const(const CPUArchState *e=
nv)
> >>> +{
> >>> +    return (const void *)env - sizeof(CPUState);
> >>> +}
> >>> +
> >>>   /**
> >>>    * env_archcpu(env)
> >>>    * @env: The architecture environment
> >>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> >>> index 81af7b9ee1a..59f777f3f15 100644
> >>> --- a/include/hw/core/cpu.h
> >>> +++ b/include/hw/core/cpu.h
> >>> @@ -594,6 +594,12 @@ struct CPUState {
> >>>   QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=3D
> >>>                     sizeof(CPUState) - sizeof(CPUNegativeOffsetState)=
);
> >>> +static inline const CPUArchState *cpu_env_const(const CPUState *cpu)
> >>> +{
> >>> +    /* We validate that CPUArchState follows CPUState in cpu-
> >>> target.c */
> >>> +    return (const CPUArchState *)(cpu + 1);
> >>> +}
> >>> +
> >>>   static inline CPUArchState *cpu_env(CPUState *cpu)
> >>>   {
> >>>       /* We validate that CPUArchState follows CPUState in cpu-
> >>> target.c */
> >>
> >> I wonder if we can use _Generic to make this automatic, rather than
> >> have to choose between two different function names.
> > Eh clever :) This seems to work:
> >
> >    #define env_archcpu_(p) _Generic(*(p), \
> >                                CPUArchState: (void *)p, \
> >                                const CPUArchState: (const void *)p)
>
> Actually simpler and even well readable:
>
> -- >8 --
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6594f7fa1b..d67d008236 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const
> CPUState *cpu)
>    *
>    * Return the ArchCPU associated with the environment.
>    */
> -static inline ArchCPU *env_archcpu(CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUState);
> -}
> -
> -/**
> - * env_cpu_const(env)
> - * @env: The architecture environment
> - *
> - * Return the CPUState associated with the environment.
> - */
> -static inline const CPUState *env_cpu_const(const CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUState);
> -}
> +#define env_archcpu(env) _Generic(*(env), \
> +            CPUArchState: \
> +                (ArchCPU *)((void *)env - sizeof(CPUState)), \
> +            const CPUArchState: \
> +                (const ArchCPU *)((const void *)env - sizeof(CPUState)))
>
>   /**
>    * env_cpu(env)
> @@ -107,9 +97,10 @@ static inline const CPUState *env_cpu_const(const
> CPUArchState *env)
>    *
>    * Return the CPUState associated with the environment.
>    */
> -static inline CPUState *env_cpu(CPUArchState *env)
> -{
> -    return (CPUState *)env_cpu_const(env);
> -}
> +#define env_cpu(env) _Generic(*(env), \
> +            CPUArchState: \
> +                (CPUState *)((void *)env - sizeof(CPUState)), \
> +            const CPUArchState: \
> +                (const CPUState *)((const void *)env - sizeof(CPUState))=
)
>
>   #endif /* CPU_COMMON_H */
> ---
>

lgtm too
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

