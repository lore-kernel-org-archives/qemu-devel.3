Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3974CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtWn-0004dv-CH; Fri, 15 May 2026 10:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtWZ-0004N7-3Y
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:28:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtWX-00021Y-D4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:28:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so8485665f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855299; cv=none;
 d=google.com; s=arc-20240605;
 b=gmjXBr52mC+h/pL7aQC8GHG1LKFYUjSuF3qXdwAYPwSYD/1OMqAHVRMetD/kqM4cI0
 C0B5KbTx9fgRzTHXSgPTrucnhouJ1UlK41gClmkOm1v2MXYGbJtDugCcc0y2lCB99yLo
 pb/YOF9g9LtXctRLIO5qM/D3WckiLMMJgE/peLVlqd2uWSrwGrtx87sfnJ+bxZDoLkRJ
 hwDx0dyXshDI3HVsv0CV2WQkDC9ADU83mx4uETfIZl77wi//V3EOIriQo8uSgBe0hkMS
 hg27+JST1Rrw9s5TNclPVlLG3cDj3tWBI5RMkTJOpMzfqakro/e75fbJWY+RgwVnAQQy
 zK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e6thmI8LHMZd83dauSGaPGvKYFzq9Z6zsC8vRuq9GXQ=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=R+63L3mm8/2L0+EqOYnI9CxancYPUiTCx4S7fUg7UdQdrZYPtSIZt4HMOZLhGmO7K6
 qjVRJeagq9VmlJLCmcETm4Rk9SMZ/iI04fkHpBmAd+r3GiSROPH99FzakdREj0VOrfUt
 O7dM6nABeuEU4uKnfmRLsW5kI8y7MZaUuo1iDFl86+AOX9/Nnfrr8wDLRMpWMRYvGY4h
 kJriHeI9nVsIZv9RAR3+ceJVQVmCeiQb+U/k9r2MaZYa9Fh/srwrz6mevTLji3oM44m4
 AyOaUwHCa/FoIcFld/7SBXyAICHPn3j32FS7X0pcFL7wvFl4E5gGFb2JC9zzrJhMq7kg
 ygRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855299; x=1779460099; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6thmI8LHMZd83dauSGaPGvKYFzq9Z6zsC8vRuq9GXQ=;
 b=pN09vn1qddxVRcQbdpm+wV1L3zVEQBnGkchr02U/UWeuYmuj7YcDRCHNRMHf53sayc
 ua4YS3Oa34XVEvOrJLmAfd8MVijaK1rKcdJrVmBjp5x0OJurIa2IIntaTukc/XxnRuRD
 I+pxPkhEg0ZsHv+fOQtkaEiOVvBSjiw2xPM7coTZZIq6pBRF3ilDREkFbvu2LPymEjYh
 fKOUr44eeRblSJXqjz+QIOTQ7lDhpE2CpkQAHWNy6PfX+k8lD0cuF6pRdPDnoRfoKi7o
 v9nQhZznB6rSYMVdp/sbswmG3ty6vLtln+RnUCHkAmlDJyZ4PsFwApm83/k1IeOfCipD
 XRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855299; x=1779460099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6thmI8LHMZd83dauSGaPGvKYFzq9Z6zsC8vRuq9GXQ=;
 b=gA1irjD22uzc6uQPYSBwurTHrJwqGkXX9pExaPErWcu+iBCGgs4CkpPFzyh1ayo56k
 DoPCrHgxj4HOSV0NyhXNia3nhNirqtmddf/+a45iAjvgk8L+RiSkX2TX0z1vwzZp3Ur+
 5+uAGpeUWfy+TAWh+bBXi3BWjaYIlCuuxbAo5sfNhHv+yuSOKjnALwCCIS3WItFHMAd2
 q2S6kC0cbgvwqt5aBaS/8YYB5q/BUf1bIhJYmFl2PgKLdkDpD7FksVBn9/qWbxXG7qZb
 zWCfiH2NyWP8szCY1DOG3BBSaVNcNe+Y2J6p7nspXlyNHltFJ9aFqrqxZcib+Nd6svYy
 JHhA==
X-Gm-Message-State: AOJu0Yy1l+32o0Xga0BKCD5eD+9jKRu0qLEQcNHZvKEBTjOrUpl0sMus
 9UXI4W4aeGgWXCIFGB0mwYrzREIPFVYkO8L7fZjrOtIw5jb30Icqjch1P5yDE9v4TSjaS8uLUD0
 2gqi6Tk4FK05yGNA8g5khdSCEzPf6EbdTwto28g1FPw==
X-Gm-Gg: Acq92OGjO+uyqtghSBWvWkEUhn4UC2p/GPO7jjA1ASyVEk9S9xX/pVdhorv8FQ8mHw+
 pqS2QZzcCQgvHpPCqyuiyTTlIS9RO4UNuok2RSP8Fz14GMwPMFK+p5PSOdaq8ceM4IBGmS5A/YN
 JMesVeufnMtMZxFvUh6ai0//sZ8G9XN+8qPGfM4fQPXvChuA8s29F5+Q6gUEveiXUURZVPORT3t
 PuKejcXML3Ts5r4D4HjUtafvlNbCaCCffAk4v7Xq6ktkRrm7NotUDiaRxRYs3A6PfCXDoKR7gSd
 NR+/zeUvkJfcb6T1kAQVHYHSfGz+oi4zsO+k7NE//ScYlh6yMw==
X-Received: by 2002:a05:6000:4205:b0:43d:7dcf:ae26 with SMTP id
 ffacd0b85a97d-45e5c5cd116mr5507358f8f.34.1778855299122; Fri, 15 May 2026
 07:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-17-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-17-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:27:49 +0300
X-Gm-Features: AVHnY4JfWSM68WGkRQpLkRNA7wvoK6nBedenhWmkj7GlNswXaoFz2GuXEVAwhVg
Message-ID: <CAAjaMXbA6xcLyG80vD89u2wwqYQkCOnP74CACBjoRsMO7K9zqQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/20] target/arm: Factor aarch64_aa32_a57_init() out
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Fri, May 15, 2026 at 5:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> In order to make the following commit easier to review,
> factor aarch64_aa32_a57_init() out of aarch64_a57_initfn()
> as a preliminary step. We only add a %aa32_only argument
> to restrict AArch64 features.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/cpu64.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 7b2f09cf8ec..7dce17fdb20 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -686,17 +686,20 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error *=
*errp)
>      SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
>  }
>
> -static void aarch64_a57_initfn(Object *obj)
> +static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
>      ARMISARegisters *isar =3D &cpu->isar;
> +    const bool aarch64_enabled =3D !aa32_only;
>
>      cpu->dtb_compatible =3D "arm,cortex-a57";
>      set_feature(&cpu->env, ARM_FEATURE_V8);
>      set_feature(&cpu->env, ARM_FEATURE_NEON);
>      set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
>      set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
> -    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    if (aarch64_enabled) {
> +        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    }
>      set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
>      set_feature(&cpu->env, ARM_FEATURE_EL2);
>      set_feature(&cpu->env, ARM_FEATURE_EL3);
> @@ -727,10 +730,12 @@ static void aarch64_a57_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR4, 0x00011142);
>      SET_IDREG(isar, ID_ISAR5, 0x00011121);
>      SET_IDREG(isar, ID_ISAR6, 0);
> -    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
> -    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
> -    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
> -    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
> +    if (aarch64_enabled) {
> +        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
> +        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
> +        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
> +        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
> +    }
>      cpu->isar.dbgdidr =3D 0x3516d000;
>      cpu->isar.dbgdevid =3D 0x01110f13;
>      cpu->isar.dbgdevid1 =3D 0x2;
> @@ -742,14 +747,21 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->ccsidr[1] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB=
, 2);
>      /* 2048KB L2 cache */
>      cpu->ccsidr[2] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB=
, 7);
> -    set_dczid_bs(cpu, 4); /* 64 bytes */
> -    cpu->gic_num_lrs =3D 4;
> -    cpu->gic_vpribits =3D 5;
> -    cpu->gic_vprebits =3D 5;
> -    cpu->gic_pribits =3D 5;
> +    if (aarch64_enabled) {
> +        set_dczid_bs(cpu, 4); /* 64 bytes */
> +        cpu->gic_num_lrs =3D 4;
> +        cpu->gic_vpribits =3D 5;
> +        cpu->gic_vprebits =3D 5;
> +        cpu->gic_pribits =3D 5;
> +    }
>      define_cortex_a72_a57_a53_cp_reginfo(cpu);
>  }
>
> +static void aarch64_a57_initfn(Object *obj)
> +{
> +    aarch64_aa32_a57_init(obj, false);
> +}
> +
>  static void aarch64_a53_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -886,7 +898,7 @@ static void aarch64_max_initfn(Object *obj)
>      }
>
>      if (tcg_enabled() || qtest_enabled()) {
> -        aarch64_a57_initfn(obj);
> +        aarch64_aa32_a57_init(obj, false);
>      }
>
>      /* '-cpu max' for TCG: we currently do this as "A57 with extra thing=
s" */
> --
> 2.53.0
>

