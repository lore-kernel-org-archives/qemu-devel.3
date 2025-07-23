Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7749AC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uebzV-0006br-AE; Wed, 23 Jul 2025 12:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uebz5-0005xW-IQ
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:06:23 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uebz3-0003p5-Q9
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:06:23 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70f94fe1e40so12417047b3.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753286780; x=1753891580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vSGrhNHEwYU0lQMKHvf2QPzMKfk0ILIx2rv+NoDssE=;
 b=n7Dn1o5cIZ29weba0PBH8VOpGSv6u0WEqEPprZnyWxFJwIGsphoBwWuXth0d2BcbwS
 yQIujnwZYN7oxDT8ntWewNppGjixm2X85v4pcP3Y0OxfamVkhaIKBWzghd4P9tGXigbg
 B7KHiafHDm08BQf51qTK2H1kw0Mbh+Q68z6ON/wNI/1FXm4CV2kGKp/VlLT4fsAJvYYX
 iyFhDEadvT9MKgLrYA5HqnboTI3vQMjA6A3Uz7cK5W7CNpMmDlDxAYoLN6L70hq2mSBm
 llWU3l682bOsJCSi47ZfKqb7RdypAtycXpQFVQ0AHoy4AdbL9fJI2iVw5ssaI9jkzpAu
 C+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286780; x=1753891580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vSGrhNHEwYU0lQMKHvf2QPzMKfk0ILIx2rv+NoDssE=;
 b=p0WMz1wBM+9xnFLVwuAUkgUoObpTsmaV+5FkiGITKurp90jnbjeoT070fKBeflx2TP
 z4Rrfx9judTOs/jRWbnvIdyLyS1/XphJCKPwWua52XolkWmvl8a/YKZnyFvQfbthN5RU
 yOi92AxSjzEoMNG/oB4Ld1FiFv+eTM36TYU+BgcFSsM5hPBjuziSR9guiRPhsdsJRHaQ
 ZkHEXy3DBq6xXjBfzKojDomWMCQ7Xb1X3iOl5/MlMgOEl5aX/UXy/nEmdTVU/fw9r625
 vfLqES2VmliAZ6mOowvAdNECrCMHoP/t6ywYM3NEIwgwNu1KnCHPKPoAsWopkeZtvC5c
 ds6A==
X-Gm-Message-State: AOJu0Yxg7uh013EX8O+LVtJhTmYw5Z1rQ3FIlgzYSH8Ec4q8wrbd5uBJ
 K6fow6L1IP+g2PXuFLAEtjesK+2e7gslOpL2hIXHyWDeSS/+iJFIbo96S215ZoN1fmtFmECRSEt
 pfCFsSJwXCoCdLygWfMNd/TALzUPjiBhuRzPkZRizpQ==
X-Gm-Gg: ASbGncvj3I+FENg9DU/Vgn7Gfiges9iATjR5sR7FhGtGz4MYpMTo3WtLPmBq8VEOb23
 B7+MrK96YoveK4reMRLpVPK41qTUuWbMVkotZsoAIQ0J2R+r8NlEDWyTInH7ftLiL2p2MIkzN7h
 X7hn4+1axj+2QCKxOSUe0GCXjJRyY6vC6a1kC/AMhl7DaVBoNXmAzR3UiZsMRrPz+EQdr0nVD72
 yuMq586
X-Google-Smtp-Source: AGHT+IEh5pBHeb66mo0LTS4E4tZfL/BcjEb0VgDJ2TNUmnsvDjiF/q+TJuGahequE60YQ67TZe4kKLaNYJKGlw0dyIo=
X-Received: by 2002:a05:690c:7107:b0:70e:2daa:65b7 with SMTP id
 00721157ae682-719a0b53556mr102529697b3.12.1753286780320; Wed, 23 Jul 2025
 09:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250723135156.85426-1-philmd@linaro.org>
 <20250723135156.85426-5-philmd@linaro.org>
In-Reply-To: <20250723135156.85426-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jul 2025 17:06:08 +0100
X-Gm-Features: Ac12FXwEs_KJkhbGkhaYXW4dnpaJQ9Exigs3r_seXukmG1-qzLvHFqhfqXBXMM0
Message-ID: <CAFEAcA8gp3v2D08hmR0CCtE9G8Jv6LgcQbKxN5sz6gYq8ODcrw@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v4 4/4] target/arm/hvf: Really set Generic Timer
 counter frequency
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 23 Jul 2025 at 14:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
> not correct because the timers have already be initialized
> with the default frequency.
>
> Set it earlier in the AccelOpsClass::cpu_target_realize()
> handler instead, and assert the value is correct when
> reaching hvf_arch_init_vcpu().

Could we say here what the user-visible consequences of
getting this wrong were ?

> Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/hvf/hvf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 7de770da4f3..ea9e6b1c0c6 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1007,6 +1007,13 @@ cleanup:
>      return ret;
>  }
>
> +static uint64_t get_cntfrq_el0(void)
> +{
> +    uint64_t freq_hz =3D 0;
> +    asm volatile("mrs %0, cntfrq_el0" : "=3Dr"(freq_hz));
> +    return freq_hz;
> +}
> +
>  int hvf_arch_init_vcpu(CPUState *cpu)
>  {
>      ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> @@ -1018,7 +1025,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      int i;
>
>      env->aarch64 =3D true;
> -    asm volatile("mrs %0, cntfrq_el0" : "=3Dr"(arm_cpu->gt_cntfrq_hz));
> +
> +    /* system count frequency sanity check */
> +    assert(arm_cpu->gt_cntfrq_hz =3D=3D get_cntfrq_el0());
>
>      /* Allocate enough space for our sysreg sync */
>      arm_cpu->cpreg_indexes =3D g_renew(uint64_t, arm_cpu->cpreg_indexes,
> @@ -1083,6 +1092,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>
>  bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
>  {
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +
> +    cpu->gt_cntfrq_hz =3D get_cntfrq_el0();

Maybe worth a short comment
/*
 * We must set the counter frequency hvf will be using
 * early, before arm_cpu_realizefn initializes the timers
 * with it.
 */


What happens in the case where we're doing "try hvf, fall
back to tcg if hvf not possible" ? I guess we must figure out
that hvf won't work quite early, and well before we get to the
hvf_arch_cpu_realize() hook?

-- PMM

