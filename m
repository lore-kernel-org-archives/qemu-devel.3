Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE80BC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Xdw-0006F7-I3; Thu, 03 Apr 2025 23:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Xdu-0006EI-MJ; Thu, 03 Apr 2025 23:22:54 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Xds-0002cO-TL; Thu, 03 Apr 2025 23:22:54 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-523fa0df55dso2481053e0c.1; 
 Thu, 03 Apr 2025 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743736971; x=1744341771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ2t4HJfWMH0saYBzZEBkEVDkW1I3VhyOcuQnNFzTO4=;
 b=RwqZjFtM1u8nr+UThPB9x1JbC7kqDIW4HHgc0ZRxJgPuTPfHW6T3uyvDMQobY00IBj
 BMPt9WlZzi/kXThwEAuOX3fqMBKGpNH2ldU+pEqBkaVbtPKenRkTL0oCefJSIGCa4WZ3
 Shfg75qL7J0jxMmzw87pSwKVu0qIh0tSIMdCljehcAzMwk8VlIZQ3SSmZd3HWj/5QyU6
 8EaieY0ePvDUxSo/BwytX3ZKhW9xLhdbwd3Pa2wp8DZ98l8G7KiJj+v8WGJo8g1h8MrH
 JIp1nUvGZetkMVSS83NVx88X6MK0y8+ObUVCaSF1DGyugwFfNBujk8pBaSSQak8eaaw/
 ZUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736971; x=1744341771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZ2t4HJfWMH0saYBzZEBkEVDkW1I3VhyOcuQnNFzTO4=;
 b=g6tSqUcCvzOFDtP/aoBo7apE1IQAnuwCuhiykCftg9p1Aksqfbl+/1XSHZAhaE5Jh1
 KmgURhWbPKSAy87xCEC13dDfWbwb6MvBX4EoxTf4a3pJp2fUc0J3/novVOHBJ+iL7pcJ
 uta/wYcmKHMSO0GQvm+aItAO7BSxaYt26Y7XQLfoHyBs4bvdETJ4Cg+AkQXtjpKD3Ie8
 Uww70m96S1GjLWt3h0VlSgCMsHC8Nd2vwq3NkF+s+5PInZX35Nd5k67L/tWK+qMPF0PB
 D5rUV5xrjuEBjdRRfDPX9V4tUvrL+sguA8bhU9Inrg3LAkSSg17xvLkH/VgcVqiHwYqA
 gSFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrRgyeo7q0dARUimaRbDkX37M1AOSgqNSdtI4nTKAbAHH7Naor1Bp2ddL+UFDOUFdvaJFK3ZUJhzHR@nongnu.org,
 AJvYcCVbq/nm4VB5KLSI6uak+s6LSATfPSqjzMPuIF8la9f6EPkCq/xMu5m4buqJ5hqjaQod+UXKBmHW+FQpMw==@nongnu.org
X-Gm-Message-State: AOJu0YzdP9SIshIh9f5EsdOspzHEzLql7N2NLT78iy5Z85fd3EL5tvix
 NxRCX/KGMTUyAeO3JyA4tnIKie1Xm3UZ0pdXGhegdK2ixSAIsiljrr9ItHnJv07/uqLZHG64voi
 sV5jGBzF04qI92jVvAiQVewhnkC0=
X-Gm-Gg: ASbGncuXDQctPo4XstDeV9BamrAr31h9ma8UYljVC1dFCRMFrxgaBQiZ9HfSKF8hNfS
 k1QDAOu64WUovyEAprnmHIPp9Pr/Q2lxU8iVzTvixCcumyBolLYsaqlo6dv6OhRkxBwtT5sWwD5
 rfZdqz6wy0pE6R1E5WycGeCxYbdq0SfmALwJXATnOOrp0gk7w854D0+WMF
X-Google-Smtp-Source: AGHT+IESlxFoob8dWGJfZGLDaSwMplRlyGvZ63+SY7GsUc6LRoq0YbWCOSxOieY2bKlLAa7XZDCMD0yQycBSe/HP8os=
X-Received: by 2002:a05:6122:885:b0:523:771e:8b81 with SMTP id
 71dfb90a1353d-52756b6be18mr4904025e0c.7.1743736971355; Thu, 03 Apr 2025
 20:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-2-philmd@linaro.org>
 <2650b68f-e705-4994-9791-0bf8b2e01d74@linaro.org>
 <43e170ad-d4e3-489d-a049-22361cd34f13@linaro.org>
 <90049822-b71a-4120-9537-7d43caf44f83@linaro.org>
In-Reply-To: <90049822-b71a-4120-9537-7d43caf44f83@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 13:22:25 +1000
X-Gm-Features: ATxdqUG_8ZIFOQrkqkQx85njyB1WtetoFPJlwcOXe0nQVRI2KqAtwFXtZREabPA
Message-ID: <CAKmqyKNiCsp5eYLdOuQuSBQ3aWwUEMNEjuimGdBEYjNGcyJS_A@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 1/4] target/riscv: Restrict RV128 MTTCG check on
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anton Johansson <anjo@rev.ng>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv <qemu-riscv@nongnu.org>, Frank Chang <frank.chang@sifive.com>, 
 Bin Meng <bmeng@tinylab.org>, Andrew Jones <ajones@ventanamicro.com>, 
 Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 3, 2025 at 12:41=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 2/4/25 16:25, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 23/3/25 19:08, Richard Henderson wrote:
> >> On 3/21/25 08:59, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Multi-threaded TCG only concerns system emulation.
> >>
> >> That's not really true.  User emulation simply has no option to
> >> run in a single-threaded context.
> >>
> >> I really don't think we should allow RV128 in user-mode at all.
> >> Certainly not until there's a kernel abi for it.
> >
> > It seems to be safe since commit 905b9fcde1f ("target/riscv: Replace
> > is_32bit with get_xl/get_xlen"):
> >
> >   #ifdef TARGET_RISCV32
> >   #define get_xl(ctx)    MXL_RV32
> >   #elif defined(CONFIG_USER_ONLY)
> >   #define get_xl(ctx)    MXL_RV64
> >   #else
> >   #define get_xl(ctx)    ((ctx)->xl)
> >   #endif
> >
> > Should we undefine MXL_RV128 on user-mode?
>
> Indeed the CPU is exposed on user-mode...
>
> $ qemu-riscv64 -cpu help
> Available CPUs:
>    max
>    rv64
>    rv64e
>    rv64i
>    rva22s64
>    rva22u64
>    rva23s64
>    rva23u64
>    shakti-c
>    sifive-e51
>    sifive-u54
>    thead-c906
>    tt-ascalon
>    veyron-v1
>    x-rv128           <---------
>    xiangshan-nanhu
>
> Per commit 6df3747a274 ("riscv: Introduce satp mode hw
> capabilities") I wonder if this is expected.

We probably didn't really think about it at the time.

I agree that we don't need it

>
> Anyhow, I'll post a patch disabling it as:

Thanks

Alistair

>
> -- >8 --
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 430b02d2a58..33abcef0073 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -699,3 +699,3 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj=
)
>
> -#ifdef CONFIG_TCG
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>   static void rv128_base_cpu_init(Object *obj)
> @@ -710,7 +710,6 @@ static void rv128_base_cpu_init(Object *obj)
>       env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> +
>       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> -#endif
>   }
> -#endif /* CONFIG_TCG */
> +#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
>
> @@ -3257,3 +3256,3 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>                                                    MXL_RV64,
> rv64_xiangshan_nanhu_cpu_init),
> -#ifdef CONFIG_TCG
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128,
> rv128_base_cpu_init),
>
> ---
>

